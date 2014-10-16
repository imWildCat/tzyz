# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Node.create([
#                 {
#                     name: '校友会',
#                     slug: 'tzyz-aa',
#                     node_category_id: 1,
#                 },
#                 {
#                     name: '问与答',
#                     slug: 'qna',
#                     node_category_id: 1,
#                 }
#             ])

if Rails.env == 'development'
  @common_password = '123456'
  User.create! :nickname => 'John Doe', :email => 'john@example.com', :role_id => 1, :password => @common_password, :password_confirmation => @common_password, :confirmed_at => '2014-10-16 08:59:37'

end