Write-Host "[INFO] Pull images..."
docker compose -f docker-compose.image.yml pull

Write-Host "[INFO] Start api + worker..."
docker compose -f docker-compose.image.yml up -d api worker

Write-Host "[INFO] Done."
