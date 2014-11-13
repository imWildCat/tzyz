module NodesHelper
  def hot_nodes
    @hot_nodes = Rails.cache.read('hot_nodes')
    if @hot_nodes.nil? || @hot_nodes.count == 0
      HotNodesWorker.perform_async
      return []
    else
      Rails.cache.fetch('hot_nodes_flag', expires_in: 12.hours) do
        HotNodesWorker.perform_async
      end
    end
    @hot_nodes
  end
end