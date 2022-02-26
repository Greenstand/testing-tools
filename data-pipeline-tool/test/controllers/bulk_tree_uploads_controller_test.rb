require "test_helper"

class BulkTreeUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulk_tree_upload = bulk_tree_uploads(:one)
  end

  test "should get index" do
    get bulk_tree_uploads_url
    assert_response :success
  end

  test "should get new" do
    get new_bulk_tree_upload_url
    assert_response :success
  end

  test "should create bulk_tree_upload" do
    assert_difference("BulkTreeUpload.count") do
      post bulk_tree_uploads_url, params: { bulk_tree_upload: { key: @bulk_tree_upload.key, processed: @bulk_tree_upload.processed } }
    end

    assert_redirected_to bulk_tree_upload_url(BulkTreeUpload.last)
  end

  test "should show bulk_tree_upload" do
    get bulk_tree_upload_url(@bulk_tree_upload)
    assert_response :success
  end

  test "should get edit" do
    get edit_bulk_tree_upload_url(@bulk_tree_upload)
    assert_response :success
  end

  test "should update bulk_tree_upload" do
    patch bulk_tree_upload_url(@bulk_tree_upload), params: { bulk_tree_upload: { key: @bulk_tree_upload.key, processed: @bulk_tree_upload.processed } }
    assert_redirected_to bulk_tree_upload_url(@bulk_tree_upload)
  end

  test "should destroy bulk_tree_upload" do
    assert_difference("BulkTreeUpload.count", -1) do
      delete bulk_tree_upload_url(@bulk_tree_upload)
    end

    assert_redirected_to bulk_tree_uploads_url
  end
end
