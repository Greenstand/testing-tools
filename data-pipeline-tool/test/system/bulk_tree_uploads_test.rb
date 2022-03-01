require "application_system_test_case"

class BulkTreeUploadsTest < ApplicationSystemTestCase
  setup do
    @bulk_tree_upload = bulk_tree_uploads(:one)
  end

  test "visiting the index" do
    visit bulk_tree_uploads_url
    assert_selector "h1", text: "Bulk tree uploads"
  end

  test "should create bulk tree upload" do
    visit bulk_tree_uploads_url
    click_on "New bulk tree upload"

    fill_in "Key", with: @bulk_tree_upload.key
    check "Processed" if @bulk_tree_upload.processed
    click_on "Create Bulk tree upload"

    assert_text "Bulk tree upload was successfully created"
    click_on "Back"
  end

  test "should update Bulk tree upload" do
    visit bulk_tree_upload_url(@bulk_tree_upload)
    click_on "Edit this bulk tree upload", match: :first

    fill_in "Key", with: @bulk_tree_upload.key
    check "Processed" if @bulk_tree_upload.processed
    click_on "Update Bulk tree upload"

    assert_text "Bulk tree upload was successfully updated"
    click_on "Back"
  end

  test "should destroy Bulk tree upload" do
    visit bulk_tree_upload_url(@bulk_tree_upload)
    click_on "Destroy this bulk tree upload", match: :first

    assert_text "Bulk tree upload was successfully destroyed"
  end
end
