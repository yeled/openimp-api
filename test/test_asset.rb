require 'test/common'

class TestAsset < Test::Unit::TestCase

  def setup
    @encoding_repo = CI::Repository::Encoding.new(CLIENT)
    @release_repo = CI::Repository::Release.new(CLIENT)
  end

  def test_list_encodings
    list = @encoding_repo.list
    assert !list.empty?
    assert_instance_of CI::Metadata::Encoding, list.first
  end

  def test_equality_and_lack_thereof
    asset = CI::Metadata::Release.new(:upc => TEST_UPC)
    asset2 = CI::Metadata::Release.new(:upc => TEST_UPC)
    assert_equal asset, asset2
    assert_equal asset, asset
    assert_not_equal asset, 1234
    assert_not_equal asset, CI::Metadata::Release.new
    assert_not_equal CI::Metadata::Release.new, CI::Metadata::Release.new
    assert_equal 1, [asset, asset2].uniq.length
    assert_equal 1, {asset => 1}[asset2]
  end

  def test_reload
    # not desparately thorough re making sure full attributes are present post-reload but makes sure it works in a basic way
    asset = CI::Metadata::Release.new(:upc => TEST_UPC, :organisation_id => TEST_ORGANISATION_ID)
    asset_reloaded = @release_repo.reload(asset)
    assert(!asset_reloaded.equal?(asset))
    assert_equal asset, asset_reloaded
    assert(asset.reload!.equal?(asset))
  end
end
