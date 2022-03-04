class BulkTreeUpload < ApplicationRecord
  self.table_name = 'bulk_tree_upload'
  default_scope { order(created_at: :desc) }
end
