#language:ru
@test

Функционал: Тестирование сервиса vk.com
  •	Создать приватный альбом
  •	Добавить фотографию в альбом
  •	Сделать фотографию обложкой альбома
  •	Прокомментировать фотографию
  •	Добавить отметку на фотографию
  •	Создать публичный альбом
  •	Перенести туда фотографию
  •	Удалить первый альбом

  Сценарий: Работа с альбомами Вконтакте

    # создать приватный альбом
    * создать запрос
      | method | url                                          |
      | GET    | https://api.vk.com/method/photos.createAlbum |
    * добавить query параметры
      | access_token    | fromProperties |
      | user_ids        | fromProperties |
      | v               | 5.131          |
      | test_mode       | 1              |
      | title           | testAlbum      |
      | description     | testAlbum      |
      | privacy_view    | nobody         |
      | privacy_comment | nobody         |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | album_id | $.response.id |

         # получаем адрес сервера для загрузки
    * создать запрос
      | method | url                                              |
      | GET    | https://api.vk.com/method/photos.getUploadServer |
    * добавить query параметры
      | access_token | fromProperties |
      | user_ids     | fromProperties |
      | v            | 5.131          |
      | test_mode    | 1              |
      | album_id     | ${album_id}    |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | upload_url | $.response.upload_url |
      | album_id   | $.response.album_id   |

    # загружаем фото
    * создать запрос с параметрами по ссылке из контекста upload_url
    * добавить query параметры
      | access_token | fromProperties |
      | v            | 5.131          |
      | test_mode    | 1              |
      | album_id     | album_id       |
    * добавить файлы
      | file1 | D:/file.jpg |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | server      | $.server      |
      | photos_list | $.photos_list |
      | hash        | $.hash        |
      | aid         | $.aid         |

    # сохраняем фото на сервере
    * создать запрос
      | method | url                                   |
      | POST   | https://api.vk.com/method/photos.save |
    * добавить query параметры
      | access_token | fromProperties   |
      | v            | 5.131            |
      | caption      | somephoto        |
      | server       | ${server}        |
      | photos_list  | [${photos_list}] |
      | hash         | ${hash}          |
      | aid          | ${aid}           |
      | album_id     | ${album_id}      |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | photo_id | $.response..id       |
      | owner_id | $.response..owner_id |

    # сделать обложкой альбома
    * создать запрос
      | method | url                                        |
      | GET    | https://api.vk.com/method/photos.makeCover |
    * добавить query параметры
      | access_token | fromProperties |
      | v            | 5.131          |
      | album_id     | ${album_id}    |
      | photo_id     | ${photo_id}    |
      | owner_id     | ${owner_id}    |
    * отправить запрос
    * статус код 200

    # добавить коммент к фото
    * создать запрос
      | method | url                                        |
      | GET    | https://api.vk.com/method/photos.createComment |
    * добавить query параметры
      | access_token | fromProperties |
      | v            | 5.131          |
      | owner_id     | ${owner_id}    |
      | photo_id     | ${photo_id}    |
      | message      | cool look!     |
      | sticker_id   | 2              |
      | access_token | fromProperties |
    * отправить запрос
    * статус код 200

  #	Добавить отметку на фотографию --
    * создать запрос
      | method | url                                        |
      | GET    | https://api.vk.com/method/photos.putTag |
    * добавить query параметры
      | access_token | fromProperties |
      | v            | 5.131          |
      | owner_id     | ${owner_id}    |
      | photo_id     | ${photo_id}    |
      | user_id      | 67478889       |
      | x            | 2              |
      | y            | 2              |
      | x2           | 10             |
      | y2           | 10             |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | tag_id | $.response |

        # создать публичный альбом
    * создать запрос
      | method | url                                          |
      | GET    | https://api.vk.com/method/photos.createAlbum |
    * добавить query параметры
      | access_token    | fromProperties |
      | user_ids        | fromProperties |
      | v               | 5.131          |
      | test_mode       | 1              |
      | title           | testAlbum      |
      | description     | testAlbum      |
      | privacy_view    | all             |
      | privacy_comment | nobody         |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | album_id_all | $.response.id |

    # перенести фото в новый альбом
    * создать запрос
      | method | url                        |
      | GET    | https://api.vk.com/method/photos.move |
    * добавить query параметры
      | access_token    | fromProperties  |
      | user_ids        | fromProperties  |
      | v               | 5.131           |
      | test_mode       | 1               |
      | owner_id        | ${owner_id}     |
      | target_album_id | ${album_id_all} |
      | photo_id        | ${photo_id}     |
    * отправить запрос
    * статус код 200

    # удалить приватный альбом
    * создать запрос
      | method | url                        |
      | GET    | https://api.vk.com/method/photos.deleteAlbum |
    * добавить query параметры
      | access_token | fromProperties |
      | user_ids     | fromProperties |
      | v            | 5.131          |
      | test_mode    | 1              |
      | album_id     | ${album_id}    |
    * отправить запрос
    * статус код 200
