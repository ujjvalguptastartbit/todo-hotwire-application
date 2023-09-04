class Todo < ApplicationRecord
    validates :title, presence: true
     after_create_commit { broadcast_prepend_to 'todo'}
    after_update_commit  { broadcast_replace_to 'todo'}
    after_destroy_commit {broadcast_remove_to 'todo'}
end
