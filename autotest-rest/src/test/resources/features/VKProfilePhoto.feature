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
      | GET    | https://api.vk.com/method/photos.getOwnerPhotoUploadServer |

    * добавить query параметры
      | access_token | fromProperties |
      | user_ids     | fromProperties |
      | v            | 5.131          |
      | test_mode    | 1              |
      | owner_id     | fromProperties |

    * отправить запрос
    * статус код 200
    * извлечь данные
      | upload_url | $.response.upload_url |

    # загружаем фото
    * создать запрос с параметрами по ссылке из контекста upload_url

    * добавить query параметры
      | access_token | fromProperties |
      | v            | 5.131          |
      | test_mode    | 1              |

    * добавить файлы
      | file1 | D:/file.jpg |

    * отправить запрос
    * статус код 200
    * извлечь данные
      | server | $.server |
      | photo  | $.photo       |
      | mid   | $.mid   |
      | hash    | $.hash    |
      | message_code    | $.message_code    |
      | profile_aid   | $.profile_aid    |

    # сохраняем фото на сервере
    * создать запрос
      | method | url                                   |
      | POST   | https://api.vk.com/method/photos.saveOwnerPhoto |

    * добавить query параметры
      | access_token | fromProperties |
      | v            | 5.131          |
      | server       | ${server}      |
      | photo        | [${photo}]     |
      | hash         | ${hash}        |

    * отправить запрос
    * статус код 200








