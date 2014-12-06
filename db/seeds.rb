# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# nodes = [
#     { name: '校友会', slug: 'tzyz' },
#     { name: '问与答', slug: 'qna', description: '一个更好的世界需要你持续地提出好问题'},
#     { name: '创意', slug: 'idea' },
#     { name: '生活', slug: 'life' },
#     { name: '城市', slug: 'city' },
#     { name: '校园', slug: 'campus' },
#     { name: '工作', slug: 'work' },
#     { name: '科技', slug: 'tech' },
#     { name: '品牌', slug: 'brand' },
#     { name: '海外', slug: 'oversea'},
#     { name: 'Apple', slug: 'apple' }
# ]

LOREM_IPSUM = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae quam iaculis, hendrerit purus ac, aliquam velit. Duis et condimentum neque, vitae vehicula nisi. Fusce mollis ac quam a pharetra. Cras volutpat lectus id fringilla ultrices. Curabitur imperdiet turpis est. Morbi lobortis nisi justo, quis ornare urna viverra in. In.'

# data = JSON.parse(File.read('db/data.json'))
data = YAML::load_file('db/data.yml')

data['categories'].each do |c|
  cate = NodeCategory.create(c.slice('name', 'slug'))
  cate.nodes.create(c['nodes']) if c['nodes']
end

if Rails.env == 'development'
  common_password = '123456'
  admin = User.create! :nickname => '管理员', :email => 'admin@tzyz.com', :password => common_password, :password_confirmation => common_password, :confirmed_at => '2014-10-16 08:59:37', :fortune => 2000

  User.create(
      nickname: '李华',
      email: 'lihua@tzyz.com',
      password: common_password,
      confirmed_at: '2014-10-15 20:18:14',
      confirmation_sent_at: '2014-10-15 20:18:13',
      :fortune => 2000
  )


  100.times do |count|
    random_user = User.find(rand(1..User.count))
    random_user.topics.create(
        node_id: rand(1..Node.count),
        title: "Hello world!  -- #{count}",
        content: LOREM_IPSUM
    )
  end


  99.times do |count|
    random_topic = Topic.find(rand(1..Topic.count))
    random_user = User.find(rand(1..User.count))
    random_topic.replies.create(
        author: random_user,
        content: "Reply test! --- #{count}, this is a reply with quoted reply!",
        position: random_topic.replies_count + 1,
    )
  end


end

