#!/bin/bash

dev="$HOME/development"
ws="$dev/workspace"
proj="$HOME/projects"
gnome-terminal --window --working-directory="$dev/libopensea_core" \
               --tab --working-directory="$dev/libopensea_pub_sub" \
               --tab --working-directory="$dev/libopensea" \
               --tab --working-directory="$dev/libopensea_video" \
               --tab --working-directory="$dev/libgss_types" \
               --tab --working-directory="$dev/gss_build" \
               --tab --working-directory="$dev/ubuntu_bionic_setup"

gnome-terminal --window --working-directory="$ws/libworkspace_essentials" \
               --tab --working-directory="$ws/libworkspace_widgets" \
               --tab --working-directory="$ws/workspace" \
               --tab --working-directory="$ws/workspace"

gnome-terminal --window --working-directory="$dev/opencmd" \
               --tab --working-directory="$dev/openmngr" \
               --tab --working-directory="$dev/openins" \
               --tab --working-directory="$dev/opencmd_dynamics_sim" \
               --tab --working-directory="$dev/openfls"

gnome-terminal --window --working-directory="$proj/project_opensea_environment" \
               --tab --working-directory="$proj" \
               --tab --working-directory="$proj"

gnome-terminal --window --working-directory="$HOME/vpn/"
