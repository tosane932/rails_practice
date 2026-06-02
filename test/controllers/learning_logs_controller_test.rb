require "test_helper"

class LearningLogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @learning_log = learning_logs(:one)
  end

  test "should get index" do
    get learning_logs_url
    assert_response :success
  end

  test "should get new" do
    get new_learning_log_url
    assert_response :success
  end

  test "should create learning_log" do
    assert_difference("LearningLog.count") do
      post learning_logs_url, params: { learning_log: { duration_mins: @learning_log.duration_mins, learned_on: @learning_log.learned_on, memo: @learning_log.memo } }
    end

    assert_redirected_to learning_log_url(LearningLog.last)
  end

  test "should show learning_log" do
    get learning_log_url(@learning_log)
    assert_response :success
  end

  test "should get edit" do
    get edit_learning_log_url(@learning_log)
    assert_response :success
  end

  test "should update learning_log" do
    patch learning_log_url(@learning_log), params: { learning_log: { duration_mins: @learning_log.duration_mins, learned_on: @learning_log.learned_on, memo: @learning_log.memo } }
    assert_redirected_to learning_log_url(@learning_log)
  end

  test "should destroy learning_log" do
    assert_difference("LearningLog.count", -1) do
      delete learning_log_url(@learning_log)
    end

    assert_redirected_to learning_logs_url
  end
end
