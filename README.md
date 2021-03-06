# テーブル設計

## usersテーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
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

| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| description        | text       | null: false                    |
| category_id        | integer    | null: false                    |
| item_status_id     | integer    | null: false                    |
| price              | integer    | null: false                    |
| delivery_burden_id | integer    | null: false                    |
| prefecture_id      | integer    | null: false                    |
| delivery_days_id   | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |
|                    |            |                                |



### Association

- belongs_to :user
- has_one :buyer
- belongs_to_active_hash :category
- belongs_to_active_hash :item_status
- belongs_to_active_hash :delivery_burden
- belongs_to_active_hash :prefecture
- belongs_to_active_hash :delivery_days




## deliveriesテーブル


| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| post_code     | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| buyer         | references | null: false, foreign_key: true |



### Association

- belongs_to :buyer
- belongs_to_active_hash :prefecture




## buyersテーブル


| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false,foreign_key: true  |



### Association

- belongs_to :user
- belongs_to :item
- has_one :delivery




