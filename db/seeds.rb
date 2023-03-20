# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(
  email: 'admin@iro',
  password: 'asdf4567'
)

Tag.create!(
  [
    {name: '質問'},
    {name: '練習記録'},
    {name: '弾き語り'},
    {name: 'ピアノ'},
    {name: 'ギター'},
    {name: 'アコギ'},
    {name: 'ベース'},
    {name: 'ドラム'},
    {name: 'バイオリン'},
    {name: 'トランペット'},
    {name: 'フルート'},
    {name: 'クラリネット'},
    {name: 'クラシック'},
    {name: 'ジャズ'},
    {name: 'バンド'},
    {name: 'ロック'},
    {name: '洋楽'},
    {name: '邦楽'},
    {name: 'K-POP'},
  ]
  )