# Цель

Проверить удалённый Windows хост на соответствие всем параметрам, необходимым для работы "Продукта А"

# Инструменты и ресурсы

- Powershell

- Транспорт подключения к удалённому хосту - SSH 

На удалённом Windows хосте настроена и запущена Feature "OpenSSH сервер" (при необходимости "OpenSSH клиент"), соединение происходит с помощью ключей RSA/ED25519

- Удалённый хост при необходимости предоставим, нужен будет публичный ключ исполнителя в соответстующем формате

# Функциональные требования

- Отклонение от любого из заданного параметра выводить в stdout (планируется использовать скрипт как часть pipeline в дальнейшем)

- При наличии любого из отклонений Exit Code 1 (планируется использовать скрипт как часть pipeline в дальнейшем)

- Конечный лог работы (CSV/JSON/YAML на выбор) скопировать на SFTP, указанный в конфигурации (для простоты - на тот же хост)

- Конфигурация в JSON/YAML на выбор 

В конфигурации указываются хосты подключения, параметры (при необходимости) подключения, собираемая информация о параметрах инфраструктуры:

- - Таймзона GMT+3

- - Системная учётная запись *svc_acc* имеет свойство "Account expires" равным False

- - Системная учётная запись *svc_acc* имеет свойство "PasswordNeverExpires" равным DisablePasswordExpiration

- - Сервис (служба) с именем *sshd* в статусе Running
