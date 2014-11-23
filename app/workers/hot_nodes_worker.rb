class HotNodesWorker
  include Sidekiq::Worker

  sidekiq_options :queue => :statistics, :retry => 5

  def perform
    candidates = Node.all
    statistics = []
    candidates.each do |c|
      count = Topic.where(:node => c).count.to_i
      statistics.push({
          :node => c,
          :count => count,
                       })
    end

    # Sort and select top 5
    statistics = statistics.sort_by { |s| s[:count] }.reverse!.first 5

    hot_nodes = []
    statistics.each do |s|
      hot_nodes.push s[:node]
    end

    Rails.cache.write('hot_nodes', hot_nodes)
  end

end
