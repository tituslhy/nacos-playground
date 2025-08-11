# nacos-playground
This repository is a companion resource to the Medium Article: [The Discovery Channel: Introducing Nacos Registry](https://medium.com/mitb-for-all/towards-general-discoverability-introducing-nacos-registry-60fa2e1a8731)

<p align="center">
    <img src="./images/0. registry.webp">
</p>

The main codes used for the article are in `notebooks/nacos.ipynb`. For further information, I've also included another short notebook `notebooks/nacos_v3.ipynb` to walkthrough how to use Nacos' v3 SDK.

## Setup
This repository uses the uv package installer.

To create a virtual environment with the dependencies installed, simply type in your terminal:
```
uv sync
```

To spin up your Nacos registry, run:
```
docker compose up -d
```