# sharding-repl-cache

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```
Выполняем настройки для шардирования и репликации

```shell
./scripts/configurate.sh
```


Заполняем mongodb данными

```shell
./scripts/mongo-init.sh
```

## Как проверить
### Шард №1
```shell
docker exec -it shard1 mongosh --port 27021
> use somedb;
> db.helloDoc.countDocuments();
> exit();
```
### Шард №2
```shell
docker exec -it shard2 mongosh --port 27022
> use somedb;
> db.helloDoc.countDocuments();
> exit();
```
### Если вы запускаете проект на локальной машине

Откройте в браузере http://localhost:8080

### Если вы запускаете проект на предоставленной виртуальной машине

Узнать белый ip виртуальной машины

```shell
curl --silent http://ifconfig.me
```

Откройте в браузере http://<ip виртуальной машины>:8080

## Доступные эндпоинты

Список доступных эндпоинтов, swagger http://<ip виртуальной машины>:8080/docs