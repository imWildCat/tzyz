# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

LOREM_IPSUM = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut vitae quam iaculis, hendrerit purus ac, aliquam velit. Duis et condimentum neque, vitae vehicula nisi. Fusce mollis ac quam a pharetra. Cras volutpat lectus id fringilla ultrices. Curabitur imperdiet turpis est. Morbi lobortis nisi justo, quis ornare urna viverra in. In.'


default_node_categories = NodeCategory.create(name: '默认分类', slug: 'default')

default_node_categories.nodes.create([
    {
        name: '校友会',
        slug: 'tzyz-aa',
    },
    {
        name: '问与答',
        slug: 'qna',
    }
                                     ])


admin = User.create(
    nickname: 'admin',
    email: 'admin@tzyz.com',
    password: 'password',
    confirmed_at: '2014-10-15 20:18:14',
    confirmation_sent_at: '2014-10-15 20:18:13'
)


qna_node = Node.find_by_slug('qna')
(1..100).each do |count|
  admin.topics.create(
      node_id: qna_node.id,
      title: "Hello world!  --#{count}",
      content: LOREM_IPSUM
  )
end

t = admin.topics.create(
    node_id: qna_node.id,
    title: 'Hello world! --Reply test',
    content: 'Reply me!'
)

(1..100).each do |count|
  t.replies.create(
      user: admin,
      content: "Reply test! ---#{count}"
  )
end
