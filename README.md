# web-4-sem
## РК
## Какие виды методов HTTP запроса бывают. Рассказать про особенности и способы применения каждого метода. Привести примеры применения методов для разработанного вами API.
### Виды методов HTTP запроса

HTTP определяет множество методов запроса, которые указывают, какое желаемое действие выполнится для данного ресурса. Несмотря на то, что их названия могут быть существительными, эти методы запроса иногда называются HTTP глаголами. Каждый реализует свою семантику, но каждая группа команд разделяет общие свойства: так, методы могут быть безопасными, идемпотентными или кешируемыми.

#### Безопасный метод
Метод HTTP является __безопасным__, если он не меняет состояние сервера. Другими словами, безопасный метод проводит операции "только чтение" (read-only). Несколько следующих методов HTTP безопасные: _GET, HEAD или OPTIONS_. Все безопасные методы являются также ___идемпотентными___, как и некоторые другие, но при этом небезопасные, такие как _PUT или DELETE_.

Даже если безопасные методы являются по существу "только для чтения", сервер всё равно может сменить своё состояние: например, он может сохранять статистику. Что существенно, так то, когда клиент вызывает безопасный метод, то он не запрашивает никаких изменений на сервере, и поэтому не создаёт дополнительную нагрузку на сервер. Браузеры могут вызывать безопасные методы, не опасаясь причинить вред серверу: это позволяет им выполнять некоторые действия, например, предварительная загрузка без риска. Поисковые роботы также полагаются на вызовы безопасных методов.

Безопасные методы не обязательно должны обрабатывать только статичные файлы; сервер может генерировать ответ "на-лету", пока скрипт, генерирующий ответ, гарантирует безопасность: он не должен вызывать внешних эффектов, таких как формирование заказов, отправка писем и др..

Правильная реализация безопасного метода - это ответственность __серверного приложения__, потому что сам веб-сервер, будь то Apache, nginx, IIS это соблюсти не сможет. В частности, приложение не должно разрешать изменение состояния сервера запросами _GET_.


#### Идемпотентный метод
Метод HTTP является __идемпотентным__, если повторный идентичный запрос, сделанный один или несколько раз подряд, имеет один и тот же эффект, не изменяющий состояние сервера. Другими словами, идемпотентный метод не должен иметь никаких побочных эффектов (side-effects), кроме сбора статистики или подобных операций. Корректно реализованные методы _GET, HEAD, PUT и DELETE_ __идемпотентны__, но не метод _POST_. Также все безопасные методы являются идемпотентными.

Для идемпотентности нужно рассматривать только изменение фактического внутреннего состояния сервера, а возвращаемые запросами коды статуса могут отличаться: первый вызов _DELETE_ вернёт код _200_, в то время как последующие вызовы вернут код _404_. Из идемпотентности _DELETE_ неявно следует, что разработчики не должны использовать метод DELETE при реализации RESTful API с функциональностью ___удалить последнюю запись___.

Обратите внимание, что идемпотентность метода не гарантируется сервером, и некоторые приложения могут нарушать ограничение идемпотентности.


#### Кешируемые методы
__Кешируемые__ ответы - это HTTP-ответы, которые могут быть закешированы, то есть сохранены для дальнейшего восстановления и использования позже, тем самым снижая число запросов к серверу. Не все HTTP-ответы могут быть закешированы. Вот несколько ограничений:

- Метод, используемый в запросе, кешируемый, если это _GET_ или _HEAD_. Ответ для _POST_ или _PATCH_ запросов может также быть закеширован, если указан признак "свежести" данных и установлен заголовок Content-Location (en-US), но это редко реализуется. (Например, Firefox не поддерживает это согласно https://bugzilla.mozilla.org/show_bug.cgi?id=109553.) Другие методы, такие как _PUT_ и _DELETE_ не кешируемые, и результат их выполнения не кешируется.
- Коды ответа, известные системе кеширования, которые рассматриваются как кешируемые: _200, 203, 204, 206, 300, 301, 404, 405, 410, 414, 501_.
- Отсутствуют специальные заголовки в ответе, которые предотвращают кеширование: например, _Cache-Control_.

Обратите внимание, что некоторые некешируемые запросы-ответы к определённым URI могут сделать недействительным (инвалидируют) предыдущие закешированные ответы на тех же URI. Например, _PUT_ к странице pageX.html инвалидируют все закешированные ответы _GET_ или _HEAD_ запросов к этой странице.

### Краткий обзор HTTP методов
Давайте перечислим все методы _HTTP протокола_ и дадим им краткое описание. Для удобства сведем __HTTP методы__ в таблицу

### Номер	HTTP метод и его описание
1.	__HTTP метод GET__

Метода GET в HTTP используется для получения информации от сервера по заданному URI (URI в HTTP). Запросы клиентов, использующие метод GET должны получать только данные и не должны никак влиять на эти данные.

2.	__HTTP метод HEAD__

HTTP метод HEAD работает точно так же, как GET, но в ответ сервер посылает только заголовки и статусную строку без тела HTTP сообщения.

3.	__HTTP метод POST__

HTTP метод POST используется для отправки данных на сервер, например, из HTML форм, которые заполняет посетитель сайта.

4.	__HTTP метод PUT__

HTTP метод PUT используется для загрузки содержимого запроса на указанный в этом же запросе URI.

5.	__HTTP метод DELETE__ 

HTTP метод DELETE удаляет указанный в URI ресурс.

6.	__HTTP метод CONNECT__

HTTP метод CONNECT преобразует существующее соединение в тоннель.

7.	__HTTP метод OPTIONS__

HTTP метод OPTIONS используется для получения параметров текущего HTTP соединения.

8.	__HTTP метод TRACE__

HTTP метод TRACE создает петлю, благодаря которой клиент может увидеть, что происходит с сообщением на всех узлах передачи.

Мы вкратце рассмотрели все __HTTP методы__ и дали им короткую характеристику. Давайте теперь более подробно остановимся на каждом из HTTP методов и приведем несколько примеров использования HTTP методов.

### Описание HTTP метода GET. Пример использования HTTP метода GET
__HTTP метод GET__ позволяет получать информацию с HTTP сервера. Информация, получаемая от сервера может быть любой, главное, чтобы она была в форме HTTP объекта, доступ к информации при использовании метода GET осуществляется через URI. Часто бывает так, что HTTP  метод GET обращается к какому-то коду, а не к конкретной страницы (все CMS генерируют контент налету), поэтому метод GET работает так, что мы получаем не исходный код, который генерирует текст, а сам текст.

__HTTP метод GET__ бывает двух видов: условный метод GET и частичный метод GET. Давайте сперва посмотрим на условный метод GET. Когда используется условный HTTP метод GET, то к HTTP сообщению добавляются следующие поля заголовков: If-Modified-Since, If-Unmodified-Since, If-Match, If-None-Match, или If-Range. Значение таких полей является какое-либо условие и если это условие выполняется, то происходит передача объекта, который хранится по указанному URI, если же условие не выполняется, то и сервер не передает никаких данных. Условный HTTP метод GET предназначен для уменьшения нагрузки на сеть.

Давайте теперь посмотрим на особенности работы __частичного HTTP метода GET__. Особенность частичного метода GET заключается в том, что в его заголовке присутствует поле Range. Когда используется частичные метод GET полезная информация, предназначенная для человека передается кусками, после чего она из этих кусков собирается. Не напоминает ли это вам скачивание файлов по HTTP протоколу, когда мы можем остановить загрузку, отключить браузер, потом опять включить браузер и закачка будет происходить ровно с того места, где она была приостановлена. Не стоит забывать, что поля заголовков — это параметры HTTP протокола, которые определяют, как будут работать клиент и сервер.

Сервер может кэшировать ответы на запросы с __HTTP методом GET__, но при соблюдение определенных требований, о которых мы поговорим чуть позже. Давайте лучше самостоятельно напишем HTTP запрос с методом GET и посмотрим, какой ответ мы можем получить от сервера:

```php
GET /hello.htm HTTP/1.1

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)

Host: www.example.com

Accept-Language: ru-ru

Accept-Encoding: gzip, deflate

Connection: Keep-Alive
```
На такой HTTP запрос сервер ответит примерно следующее:
```php
HTTP/1.1 200 OK

Date: Mon, 27 Jul 2009 12:28:53 GMT

Server: Apache/2.2.14 (Win32)

Last-Modified: Wed, 22 Jul 2009 19:15:56 GMT

ETag: "34aa387-d-1568eb00"

Vary: Authorization,Accept

Accept-Ranges: bytes

Content-Length: 88

Content-Type: text/html

Connection: Closed

 

<html>

<body>

<h1>Hello, World!</h1>

</body>

</html>
```

### Описание HTTP метода POST. Пример использования HTTP метода POST
__HTTP метод POST__ является вторым по использованию в Интернете и нужен для того, чтобы отправлять данные на сервер. HTTP метод POST позволяет отправлять данные на сервер. Разработчики ввели метод POST в HTTP  стандарт, чтобы клиенты могли:

- оставлять сообщения на различных Интернет-ресурсах;
- передавать информацию о себе, заполняя HTML формы;

То, как будет работать метод POST определяется исключительно на стороне сервера и обычно зависит от запрашиваемого URI. Если сравнить URI, которому обращается клиент и сообщение, которое он хочет отправить с файловой системой, то URI – это папка, а сообщение клиента – это файл, который лежит в папке.

В результате выполнения __HTTP метода POST__ сервер не обязательно в качестве ресурса выдает URI, код состояния сервера при использовании HTTP метода POST может быть 200 (в этом случае вы получите какой-либо ресурс), либо 204 (в этом случае вы не получите никакого содержимого). Ответы сервера на метод POST не кэшируются, но это можно сделать принудительно, если использовать поле Cache-Control или Expires в заголовке.

Давайте приведем __пример использования HTTP метода POST__:
```php
POST /cgi-bin/process.cgi HTTP/1.1

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)

Host: www.example.com

Content-Type: text/xml; charset=utf-8

Content-Length: 88

Accept-Language: en-us

Accept-Encoding: gzip, deflate

Connection: Keep-Alive

 

<?xml version="1.0" encoding="utf-8"?>

<string xmlns="http://example.com/">Ваше сообщение</string>
```


Тогда HTTP сервер ответит примерно следующее:
```php
HTTP/1.1 200 OK

Date: Mon, 27 Jul 2009 12:28:53 GMT

Server: Apache/2.2.14 (Win32)

Last-Modified: Wed, 22 Jul 2009 19:15:56 GMT

ETag: "34aa387-d-1568eb00"

Vary: Authorization,Accept

Accept-Ranges: bytes

Content-Length: 88

Content-Type: text/html

Connection: Closed

 

<html>

<body>

<h1>Вах, братка! Твой запрос успэшно сдэлан!</h1>

</body>

</html>
```


### Описание HTTP метода HEAD. Пример использования HTTP метода HEAD
HTTP метод HEAD работает точно так же, как и метод GET, с той лишь разницей, что сервер в ответ не посылает тело HTTP сообщения. Все заголовки ответа при запросе клиента с использованием метода HEAD идентичны тем заголовкам, которые бы были, если бы использовался метод GET. Обычно HTTP метод HEAD используется для получения метаинформации об объекте без пересылки тела HTTP сообщения. Метод HEAD часто используется для тестирования HTTP соединений и достижимости узлов и ресурсов, так как нет необходимости гонять по сети содержимое, тестирование HTTP методом HEAD производится гораздо быстрее. Сервер может кэшировать свои ответы на запросы с методом HEAD. Еще одно применение метода HEAD заключается в обсуждение HTTP содержимого.

Давайте лучше самостоятельно напишем HTTP запрос с методом HEAD и посмотрим, какой ответ мы можем получить от сервера:
```php
HEAD /hello.htm HTTP/1.1

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)

Host: www.example.com

Accept-Language: ru-ru

Accept-Encoding: gzip, deflate

Connection: Keep-Alive
```
На такой HTTP запрос сервер ответит примерно следующее:
```php
HTTP/1.1 200 OK

Date: Mon, 27 Jul 2009 12:28:53 GMT

Server: Apache/2.2.14 (Win32)

Last-Modified: Wed, 22 Jul 2009 19:15:56 GMT

ETag: "34aa387-d-1568eb00"

Vary: Authorization,Accept

Accept-Ranges: bytes

Content-Length: 88

Content-Type: text/html

Connection: Closed
```


### Описание HTTP метода OPTIONS. Пример использования HTTP метода OPTIONS
HTTP метод OPTIONS используется для получения параметров HTTP соединения и другой служебной информации. Обратите внимание на то, что метод OPTIONS дает возможность запросить параметры для конкретного ресурса, указанного в URI.  Особенность HTTP метода OPTIONS заключается в том, что он не производит никаких действий с самим ресурсом (если браузер будет использовать метод OPTIONS, то он даже не станет загружать страницу).

Сервер отвечает на запрос с методом OPTIONS только опциями соединения, например он посылает поля заголовков Allow, но не пошлет Content-Type, ответы сервера на запросы с методом OPTIONS не кэшируются. Если в качестве URI указана звездочка «*», то параметры соединения передаются для сервера в целом, а не для какого-то конкретного URL. Этот метод не самый безопасный для HTTP сервера, поэтому зачастую клиенты его не могут применять из-за настроек безопасности.

Давайте посмотрим пример запроса с HTTP методом OPTIONS:
```php
OPTIONS * HTTP/1.1

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)
```
А примерно так ответит сервер на запрос с методом OPTIONS:
```php
HTTP/1.1 200 OK

Date: Mon, 27 Jul 2009 12:28:53 GMT

Server: Apache/2.2.14 (Win32)

Allow: GET,HEAD,POST,OPTIONS,TRACE

Content-Type: httpd/unix-directory
```


### Описание HTTP метода PUT. Пример использования HTTP метода PUT
HTTP метод PUT используется для загрузки содержимого запроса на указанный в этом же запросе URI. То есть HTTP запрос с методом PUT уже заранее содержат в теле сообщения какой-то объект, который должен быть сохранен на сервере по адресу, который указан в URI. Но если по данному URI уже есть какие-либо данные, то данные, поступающие из запроса с методом PUT, считаются модификацией. Если запрос с HTTP методом PUT обращается к не существующему URI, то сервер создает новый URI и сообщает об этом клиенту. Если ресурс успешно создан по средствам метода PUT, то сервер возвращает ответ с кодом состояния 201, если ресурс успешно модифицирован, то сервер вернет код 200, либо 204. Если по каким-либо причинам серверу не удается создать ресурс, то в ответ клиенту он высылает описание проблемы, возможно, с кодом ошибки клиента или кодом ошибки сервера.

Ответы сервера на HTTP метод PUT не кэшируются. Стоит обратить внимание, что метод POST и метод PUT выполняют совершенно разные операции. Метод POST обращается к ресурсу (странице или коду), которая содержит механизмы обработки сообщения метода POST, а вот метод PUT создает какой-то объект по URI, указанному в сообщение с HTTP методом PUT.

Давайте теперь посмотрим пример работы HTTP метода PUT:
```php
PUT /hello.htm HTTP/1.1

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)

Host: www.example.com

Accept-Language: ru-ru

Connection: Keep-Alive

Content-type: text/html

Content-Length: 182

 

<html>

<body>

<h1>Hello, World!</h1>

</body>

</html>
```
Сервер в этом случае сохранит файл hello.htm, он будет доступен по указанному URI, в самом файле будет находиться HTML код, который указан в теле сообщения, а в ответ сервер отправит примерно следующее:
```php
HTTP/1.1 201 Created

Date: Mon, 27 Jul 2009 12:28:53 GMT

Server: Apache/2.2.14 (Win32)

Content-type: text/html

Content-length: 30

Connection: Closed

 

<html>

<body>

<h1>The file was created.</h1>

</body>

</html>
```


### Описание HTTP метода DELETE. Пример использования HTTP метода DELETE
HTTP метод DELETE используется для удаления ресурса, указанного в URI. Действие метода DELETE может быть отменено вмешательством администратора HTTP сервера или программным кодом. Даже в том случае, когда сервер отправит вам код 200 после обработки метода DELETE, это не будет означать, что ресурс удален, это всего лишь означает, что сервер вас понял и обработал ваш запрос. Ответы сервера на HTTP метод DELETE не кэшируются.

Давайте теперь рассмотрим пример HTTP запроса, который использует метод DELETE:
```php
DELETE /hello.htm HTTP/1.1

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)

Host: www.example.com

Accept-Language: ru-ru

Connection: Keep-Alive
```
Сервер  может ответить на сообщение клиента с методом DELETE примерно следующее:
```php
HTTP/1.1 200 OK

Date: Mon, 27 Jul 2009 12:28:53 GMT

Server: Apache/2.2.14 (Win32)

Content-type: text/html

Content-length: 30

Connection: Closed

 

<html>

<body>

<h1>URL deleted.</h1>

</body>

</html>
```


### Описание HTTP метода TRACE. Пример использования HTTP метода TRACE
HTTP метод TRACE используется для получения информации о том, что происходит с сообщением на промежуточных узлах. У сообщений с HTTP методом TRACE есть конечный получатель, конечный получатель определяется значением поля заголовка Max-Forwards: первый HTTP сервер, прокси-сервер или шлюз, получивший данное сообщение с значением Max-Forwards 0 является конечным получателем. Запросы с HTTP методом TRACE не должны содержать объектов.

HTTP метод TRACE применяется для диагностики, он позволяет видеть клиенту, что происходит в каждом звене цепочки между компьютером клиента и конечным получателем, для этого существует специальное поле Via. Ответы сервера на метод TRACE не кэшируются.

Давайте теперь посмотрим пример HTTP метода TRACE:
```php
TRACE / HTTP/1.1

Host: www.example.com

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)
```
На такой HTTP запрос сервер может ответить так:
```php
HTTP/1.1 200 OK

Date: Mon, 27 Jul 2009 12:28:53 GMT

Server: Apache/2.2.14 (Win32)

Connection: close

Content-Type: message/http

Content-Length: 39

 

TRACE / HTTP/1.1

Host: www.example.com

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)
```


### Описание HTTP метода CONNECT. Пример использования HTTP метода CONNECT
HTTP метод CONNECT используется для преобразования HTTP соединения в прозрачный TCP/IP туннель.  Пожалуй, это всё, что можно сказать про HTTP метод CONNECT в контексте рассматриваемого протокола, разве что стоит добавить, что данный метод используется в основном для шифрования соединения (не путайте с кодировкой сообщений).

Давайте посмотрим пример использования HTTP метода CONNECT:
```php
CONNECT www.example.com HTTP/1.1

User-Agent: Mozilla/4.0 (compatible; MSIE5.01; Windows NT)
```
Если всё будет хорошо, то сервер ответит примерно так:
```php
HTTP/1.1 200 Connection established

Date: Mon, 27 Jul 2009 12:28:53 GMT

Server: Apache/2.2.14 (Win32)
```

### Примеры применения методов для разработанного вами API
```json
{
  "request" : {
    "urlPath" : "/sale",
    "method" : "GET"
  },
  "response" : {
    "status": 200,
    "body": "{{requ}}"
  }
}
```

```php
{
	"request": {
		"method": "GET",
		"url": "/veb-veb"
	},
	"response": {
		"status": 200,
		"bodyFileName": "../__files/veb-veb.jpg"
	}
}
```

### Ссылки на источники:
- https://developer.mozilla.org/ru/docs/Web/HTTP/Methods
- https://zametkinapolyah.ru/servera-i-protokoly/tema-7-opredelenie-metodov-http-http-method-definitions-metody-http-zaprosov.html#_HTTP
