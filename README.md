# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| name               | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name_kana    | string | null: false               |
| birth_date         | date   | null: false               |





### Association


- has_many :items
- has_many :buyers




## itemsテーブル

| Column             | Type          | Options     |
| ------------------ | ------------- | ----------- |
| name               | string        | null: false |
| description        | text          | null: false |
| category_id        | integer       | null: false |
| item_status_id     | integer       | null: false |
| price              | string        | null: false |
| delivery_burden_id | integer       | null: false |
| area_id            | integer       | null: false |
| delivery_days_id   | integer       | null: false |
| user_id            | references    |             |
| image              | ActiveStorage |             |



### Association

- belongs_to :users
- has_one :buyers



## deliveriesテーブル


| Column        | Type       | Options     |
| ------------- | ---------- | ----------- |
| post_code     | integer    | null: false |
| prefecture    | string     | null: false |
| city          | string     | null: false |
| address       | integer    | null: false |
| building_name | string     |             |
| phone_number  | string     | null: false |
| user_id       | references |             |
| buyer_id      | references |             |



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




