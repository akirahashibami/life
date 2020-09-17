class NotificationsController < ApplicationController

  def index
    # kaminariのメソッド。表示数を最大20にする
    @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    # 未確認の通知を探し、確認済になるように更新する
    @notifications.where(checked: false).each do |notification|
      notification.update_attriutes(checked: true)
    end
  end

end
