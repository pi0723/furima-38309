# テーブル設計


## usersテーブル

| Column             | Type   | Option      |
| ------------------ | ------ | ----------- |
| nickname           | string | null: false |
| email              | string | null: false |
| encrypted_password | string | null: false |
| birthday           | date   | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| read_last          | string | null: false |
| read_first         | string | null: false |

## Association

- has_many :items
- has_one  :user_profile



## profile テーブル

| Column             | Type    | Option      |
| ------------------ | ------- | ----------- |
| post_code          | string  | null: false |
| address            | string  | null: false |
| phone              | string  | null: false |

## Association

- has_one  :user_profile



## user_profile テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| user    | references | null: false, foreign_key: true |
| profile | references | null: false, foreign_key: true |

## Association

- belongs_to :user
- belongs_to :profile




## items テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| name         | string     | null: false                    |
| explanation  | text       | null: false                    |
| price        | integer    | null: false                    |
| user         | references | null: false, foreign_key: true |
| user_profile | references | null: false, foreign_key: true |
| category_id  | integer    | null: false                    |
| condition_id | integer    | null: false                    |
| postage_id   | integer    | null: false                    |
| area_id      | integer    | null: false                    |
| day_id       | integer    | null: false                    |

## Association

- belongs_to :user
- belongs_to :user_profile

extend ActiveHash::Associations::ActiveRecordExtensions

- belongs_to :category
- belongs_to :condition
- belongs_to :postage
- belongs_to :area
- belongs_to :day
