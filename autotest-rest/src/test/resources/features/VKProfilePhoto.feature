#language:ru
@test

Функционал: Тестирование сервиса vk.com, загрузка фото в профиль
  - Получение адреса для загрузки.
  - Передача содержимого файлов на полученный адрес в формате multipart/form-data.
  - Сохранение информации о загруженном файле.

  Сценарий: загрузка фото в контакт


    # получаем адрес сервера для загрузки
    * создать запрос
      | method | url                                              |
      | GET    | https://api.vk.com/method/photos.getUploadServer |

    * добавить query параметры
      | access_token | fromProperties |
      | user_ids     | fromProperties |
      | v            | 5.131          |
      | test_mode    | 1              |
      | album_id     | 241585786      |

    * отправить запрос
    * статус код 200
    * извлечь данные
      | upload_url | $.response.upload_url |

    # загружаем фото
    * создать запрос с параметрами по ссылке из контекста upload_url

    * добавить header
      | Content-Type    | multipart/form-data |
      | Accept          | application/json    |
      | Accept-Encoding | gzip, deflate, br   |
      | Connection      | keep-alive          |

    * добавить query параметры
      | access_token | fromProperties |
      | v            | 5.131          |
      | test_mode    | 1              |

    * добавить файлы
      | file1 | D:/file.jpg |

    * отправить запрос
    * статус код 200
    * извлечь данные
      | server      | $.server      |
      | photos_list | $.photos_list |
      | hash        | $.hash        |

    # сохраняем фото на сервере
    * создать запрос
      | method | url                                   |
      | POST   | https://api.vk.com/method/photos.save |

    * вставить параметры из контекста

    * добавить query параметры
      | access_token | fromProperties |
      | album_id     | fromProperties |
      | v            | 5.131          |
      | latitude     | 0              |
      | longitude    | 0              |
      | caption      | somephoto      |

    * отправить запрос
    * статус код 200








