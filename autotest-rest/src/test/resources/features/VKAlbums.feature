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
      | privacy_comment | nobody              |

    * отправить запрос
    * статус код 200
