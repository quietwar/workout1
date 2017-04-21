module ArticlesHelper
  def persisted_chats(chats)
    chats.reject{ |chat| chat.new_record? }
  end
end
