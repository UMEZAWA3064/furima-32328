# テーブル設計

## usersテーブル

| Column           | Type   | Options  |
| ---------------- | ------ | -------- |
| name             | string | NOT NULL |
| email            | string | NOT NULL |
| password         | string | NOT NULL |
| family_name      | string | NOT NULL |
| first_name       | string | NOT NULL |
| family_name_kana | string | NOT NULL |
| first_name_kana  | string | NOT NULL |
| birth_date       | date   | NOT NULL |




### Association


- has_many :items
- has_many :deliveries
- has_many :buyers




## itemsテーブル

| Column          | Type          | Options  |
| --------------- | ------------- | -------- |
| name            | string        | NOT NULL |
| description     | text          | NOT NULL |
| category        | string        | NOT NULL |
| item_status     | string        | NOT NULL |
| price           | string        | NOT NULL |
| delivery_burden | string        | NOT NULL |
| area            | string        | NOT NULL |
| delivery_days   | string        | NOT NULL |
| user_id         | references    |          |
| image           | ActiveStorage |          |



### Association

- belongs_to :users
- has_one :buyers



## deliveriesテーブル


| Column        | Type       | Options  |
| ------------- | ---------- | -------- |
| post_code     | integer    | NOT NULL |
| prefecture    | string     | NOT NULL |
| city          | string     | NOT NULL |
| address       | integer    | NOT NULL |
| building_name | string     |          |
| phone_number  | string     | NOT NULL |
| user_id       | references |          |
| buyer_id      | references |          |



### Association

- belongs_to :users
- belongs_to :buyers




## buyersテーブル


| Column  | Type       | Options |
| ------- | ---------- | ------- |
| user_id | references |         |
| item_id | references |         |



### Association

- belongs_to :users
- belongs_to :items
- has_one :deliveries




