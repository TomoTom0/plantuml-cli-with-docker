# PlantUML with Docker

## Getting Started

First, you need to install the following:

- curl
- Docker 
- Docker Compose

## How To Use

### Start PlantUML Server

```bash
docker compose up -d
```

If you want to change the port from 8080, you can modify `PORT_PLANTUML` in the `.env` file.

### Convert PlantUML to Image

Write your PlantUML code in `puml` directory and run the following command:

```bash
bash convert_puml.sh
```

The generated images will be saved in `out/png` directory.
While there is already converted images with the same name and the source plantuml files are not updated, the conversion will be skipped.

If you want to change the output extension, you can add arguments to the `convert_puml.sh` script.
The extension can be `png`, `svg`, `pdf`.

```bash
convert_puml.sh svg
```

### Stop PlantUML Server

```bash
docker compose down
```

