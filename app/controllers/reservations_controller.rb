class ReservationsController < ApplicationController
  include ApplicationHelper
  before_action:unless_login
  require 'date'
  
  def index
  end
  
  def update
    @reservation = Reservation.find(params[:id])
    
    if params[:no] == "1"
        if @reservation.update_attributes(attendance_time: Time.current.change(sec: 0))
          flash[:success] = "出席時間を登録しました。"
        else
          flash[:danger] = "出席時間の登録に失敗しました。"
        end
       redirect_to request.referrer and return
    end
      
    if params[:no] == "2"
        if @reservation.update_attributes(leave_time: Time.current.change(sec: 0))
          flash[:success] = "退席時間を登録しました。"
        else
          flash[:danger] = "退席時間の登録に失敗しました。"
        end
       redirect_to request.referrer and return
    end
  
    if params[:no] == "3"
        if @reservation.update_attributes(attendance_time: nil, leave_time: nil)
          flash[:success] = "出席と退席時間を消去しました。"
        else
          flash[:danger] = "出席と退席時間の消去に失敗しました。"
        end
       redirect_to request.referrer and return
    end

    if params[:no] == "4"
        if @reservation.update_attributes(absence: true)
          flash[:success] = "該当受講生の欠席登録しました。"
        else
          flash[:danger]  = "該当受講生の欠席登録に失敗しました。"
        end
       redirect_to request.referrer and return
    end
    
    if params[:no] == "5"
        if @reservation.update_attributes(absence: false)
          flash[:success] = "欠席登録を解除しました。"
        else
          flash[:danger] = "欠席登録の解除に失敗しました。"
        end
       redirect_to request.referrer and return
    end
    
    if params[:no] == "6"
        if @reservation.update_attributes(zoom: params[:reservation][:zoom])
           @reservation.update_attributes(fix_time: params[:reservation][:fix_time])
          flash[:success] = "固定時間と授業方法を更新しました。"
        else
          flash[:danger] = "固定時間と授業方法の更新に失敗しました。"
        end
       redirect_to request.referrer and return
    end
  end

  
  def reservations_log
    @user = User.find_by(params[:id])
  end
  
  private
  
  def reservation_params
     params.require(:reservation).permit(:zoom, :fix_time)
  end
  
end