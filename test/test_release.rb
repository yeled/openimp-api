require File.dirname(__FILE__) + '/test_common.rb'
class TestRelease < Test::Unit::TestCase
  include TestCommon

  def test_get_release
    release = CI::Metadata::Release.new(:id => TEST_UPC)
    assert_instance_of CI::Metadata::Release, release
    tracks = release.tracks
    assert_instance_of Array, tracks
    assert_instance_of CI::Metadata::Track, tracks.first
  end

  def test_get_front_cover_for_release
    release = CI::Metadata::Release.new(:id => TEST_UPC)
    assert_instance_of CI::Metadata::Release, release
    assert_equal "The Prodigy", release.main_artist
    front_cover = release.imagefrontcover
    assert_instance_of CI::File::Image, front_cover
  end
  
  def test_release_list
    list = CI::Metadata::Release.list
    assert_instance_of CI::Pager, list
    list.each do |page|
      assert_instance_of Array, page
      assert_instance_of CI::Metadata::Release, page.first
      break # we only bother to test the first
    end
  end
end