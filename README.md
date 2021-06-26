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
