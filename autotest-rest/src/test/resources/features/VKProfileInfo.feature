#language:ru
@test

Функционал: Тестирование сервиса vk.com
  - Запрос информации о профиле пользователя
  - Заполнение недостающей информации
  - Смена фото профиля

  Сценарий: Работа с профилем Вконтакте

    * создать запрос
      | method | url                                              |
      | GET    | https://api.vk.com/method/account.getProfileInfo |

    * добавить query параметры
      | access_token | fromProperties |
      | user_ids     | fromProperties        |
      | v            | 5.131          |
      | test_mode    | 1              |

    * отправить запрос
    * статус код 200
    * извлечь данные
      | id               | $.response.id               |
      | home_town        | $.response.home_town        |
      | status           | $.response.status           |
      | first_name       | $.response.first_name       |
      | last_name        | $.response.last_name        |
      | bdate            | $.response.bdate            |
      | bdate_visibility | $.response.bdate_visibility |
      | phone            | $.response.phone            |
      | relation         | $.response.relation         |
      | screen_name      | $.response.screen_name      |
      | sex              | $.response.sex              |

    #Заполнение пустых данных, не включая персональных данных, для которых формируется заявка на обновление
    * создать запрос
      | method | url                                                |
      | POST   | https://api.vk.com/method//account.saveProfileInfo |

    * добавить query параметры
      | access_token | fromProperties |
      | user_ids     | 5197813        |
      | v            | 5.131          |
      | test_mode    | 1              |
    * заполнить пустые поля и добавить их в query параметры
      | home_town | New Home Town |
      | status    | New Status    |
      | bdate     | 12.12.2012    |
      | relation  | 1             |
      | sex       | 1             |

    * отправить запрос

    * статус код 200




