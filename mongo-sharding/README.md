# mongo-sharding

## Как запустить

Запускаем mongodb и приложение

```shell
docker compose up -d
```
Выполняем настройки для шардирования

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