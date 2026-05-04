# sidarma-v2-image-deploy

Repository ini khusus untuk deployment node SIDARMA berbasis image GHCR.

Repo ini **tidak** menyimpan source code aplikasi. Source code tetap ada di repo `sidarma-v2`.
Repo ini hanya menyimpan file deployment seperti:
- `docker-compose.image.yml`
- `.env.example`
- `.env.node-c.example`
- `.env.node-d.example`
- script bantu deploy
- panduan deploy node baru

## Tujuan

Agar saat menambah node baru, operator cukup:
1. clone repo ini
2. copy `.env.node-x.example` menjadi `.env`
3. sesuaikan parameter node
4. login ke GHCR
5. pull image
6. jalankan docker compose
7. register node di web SIDARMA

## Struktur repo

```text
sidarma-v2-image-deploy/
  README.md
  .gitignore
  docker-compose.image.yml
  .env.example
  .env.node-c.example
  .env.node-d.example
  scripts/
    pull-and-up.sh
    pull-and-up.ps1
    set-portproxy-8000.ps1
```

## File penting

### `docker-compose.image.yml`
Compose image-based untuk service:
- `api`
- `worker`
- `scheduler`

### `.env.example`
Template umum untuk semua node.

### `.env.node-c.example`
Contoh node C dengan role `api,worker`.

### `.env.node-d.example`
Contoh node D dengan role `api,worker`.

## Rekomendasi role node

### Node A
- `api,scheduler,worker`

### Node B
- `api,scheduler,worker`

### Node C
- `api,worker`

### Node D
- `api,worker`

Untuk awal, scheduler cukup aktif di A/B saja. Node C/D tidak perlu scheduler dulu.

## Cara deploy node baru

### Linux / WSL

```bash
git clone https://github.com/wxradarexplore/sidarma-v2-image-deploy.git
cd sidarma-v2-image-deploy
cp .env.node-c.example .env
# edit .env

docker login ghcr.io -u wxradarexplore
./scripts/pull-and-up.sh
```

### Windows PowerShell

```powershell
git clone https://github.com/wxradarexplore/sidarma-v2-image-deploy.git
cd sidarma-v2-image-deploy
Copy-Item .env.node-c.example .env
# edit .env

docker login ghcr.io -u wxradarexplore
./scripts/pull-and-up.ps1
```

## Setelah deploy

1. cek API node baru
2. cek worker heartbeat
3. register node di menu **Nodes** di SIDARMA web
4. cek **Cluster Overview**
5. cek **Logs**

## Catatan keamanan

Jangan commit file berikut:
- `.env`
- password Mongo asli
- secret MinIO asli
- token API/registry
- log file
- runtime data

Gunakan `.env.example` dan isi secret hanya di server target.
