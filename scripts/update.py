#!/usr/bin/env python

import yaml
from string import Template
import os

config = ""

def get_layer_string(image):
    layers_string = []
    if 'layers' in image:
        for layer_name, layer in image['layers'].items():
            if layer:
                layers_string.append("(")
                layers_string.append(layer_name)
                for arg_name, arg_vals in layer.items():
                    layers_string.append(" :")
                    layers_string.append(arg_name)
                    if len(arg_vals) > 1:
                        layers_string.append("\n")
                        layers_string.append("\n".join(arg_vals))
                    else:
                        layers_string.append(" ")
                        layers_string.append(arg_vals[0])
                layers_string.append(")\n")
            else:
                layers_string.append(layer_name)
                layers_string.append('\n')
    return ''.join(layers_string)

def get_additional_packages_string(image):
    packages = []
    for package in image['additional-packages']:
        packages.append(package)
        packages.append('\n')
    return ''.join(packages)


def generate_spacemacs_config(image):
    spacemacs = image['spacemacs']
    layers = get_layer_string(spacemacs)
    additional_packages = get_additional_packages_string(spacemacs) if 'additional-packages' in image else ''
    user_init = spacemacs['user-init'] if 'user-init' in spacemacs else ''
    user_config = spacemacs['user-config'] if 'user-config' in spacemacs else ''
    includes = spacemacs['includes'] if 'includes' in spacemacs else []
    return layers, additional_packages, user_init, user_config, includes


def write_spacemacs_config(layers, additional_packages, user_init, user_config, template, destination):
    with open(destination, 'w') as dest:
        dest.write(template.substitute(
            layers=layers,
            additionalpackages=additional_packages,
            userinit=user_init,
            userconfig=user_config))

def transform_layers(layers):
    for name, commands in layers.items():
        layers[name] = ' \\\n   && '.join(commands)


def write_dockerfile(image, layers, destination_folder):
    if 'dockerfile' in image:
        dockerfile = image['dockerfile']
        dockerfile_string = []
        for command, v in dockerfile.items():
            cmd = command.split('_')[0]
            dockerfile_string.append(cmd.upper())
            dockerfile_string.append(" ")
            if cmd == 'run':
                dockerfile_string.append(layers[v])
            else:
                dockerfile_string.append(v)
            dockerfile_string.append("\n\n")
        with open(destination_folder + "Dockerfile", 'w') as dest:
            dest.write(''.join(dockerfile_string))


print("Starting update...")

with open("config.yaml", "r") as config_stream:
    try:
        config = yaml.load(config_stream)
    except yaml.YAMLError as exc:
        print(exc)

config_string = ""
with open('.spacemacs.template', 'r') as config_template:
    config_string = Template(config_template.read())
layers = config['layers']
transform_layers(layers)

configs = dict()

for image_name, image in config['images'].items():
    if not os.path.exists(image_name):
        os.makedirs(image_name)
    configs[image_name] = generate_spacemacs_config(image)
    # write_spacemacs_config(*generate_spacemacs_config(image), config_string, image_name + "/.spacemacs")
    write_dockerfile(image, layers, image_name + "/")


for image_name, config in configs.items():
    includes = config[4]
    for include in includes:
        l, p, i, c, inc = configs[include]
        configs[image_name] = (
            l + config[0],
            p + config[1],
            i + config[2],
            c + config[3],
            inc
        )
    write_spacemacs_config(*configs[image_name][0:4], config_string, image_name + "/.spacemacs")

print("Successfully updated dockerfiles!")
