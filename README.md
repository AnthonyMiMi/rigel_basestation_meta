# rigel_basestation_meta
The meta repostiory for Rigel basestation PC

## Install
A one-liner is provided for installing the software.
```shell
cd ${HOME} && wget -c https://raw.githubusercontent.com/AnthonyMiMi/rigel_basestation_meta/refs/heads/jazzy/scripts/install.sh && chmod +x install.sh && ./install.sh && rm install.sh
```
Note that this only works if the installation script is in a public repository.

For private repository, it is probably unlikely to be used by developers so no problem adding more steps:
```shell
mkdir -p ${HOME}/rigel/rigel_ws/src
cd ${HOME}/rigel
git clone -b jazzy git@github.com:AnthonyMiMi/rigel_basestation_meta.git && bash rigel_basestation_meta/scripts/install.sh
```


## Use
### Launch
```shell
ros2 launch rigel_basestation_ros basestation_bringup.launch.py
```
### Control
blah blah blah...


## Troubleshooting
blah blah blah...

## List of related repositories (optional)
- [rigel_meta](https://github.com/AnthonyMiMi/rigel_meta)
- [rigel_basestation_ros](https://github.com/AnthonyMiMi/rigel_basestation_ros)
- [rigel_common](https://github.com/AnthonyMiMi/rigel_common)
