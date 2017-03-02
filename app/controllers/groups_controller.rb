class GroupsController < ApplicationController
  before_action :set_group, only:[:edit, :show, :destroy, :modify]

  def index
    @group = Group.new
    @groups = Group.all
  end

  def new
    if request.referrer.split("/").last == "groups"
      flash[:notice] = nil
    end
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      #link to creator and make them admin
      @group.set_admin(current_user)
      respond_to do |format|
        format.html { redirect_to @group }
        format.js
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["a group with this groupname already exists"]}
        format.html { redirect_to new_group_path }
        format.js { render template: 'groups/group_error.js.erb'}
      end
    end
  end

  # def update
  #   group = Group.find_by(slug: params[:slug])
  #   group.update(group_params)
  #   redirect_to group
  # end

  def show
    @message = Message.new
    @user=User.find(current_user.id) #sets default to "member"
  end

  def destroy
    if @role=="admin"
      @group.destroy
      respond_to do |format|
        flash[:notice] = {error: ["Your group was deleted"]}
        format.html { redirect_to groups_path }
        format.js { render template: 'groups/group_error.js.erb'}
      end
    else
      respond_to do |format|
        flash[:notice] = {error: ["You are not the admin"]}
        format.html { redirect_to group_path(@group) }
        format.js { render template: 'groups/group_error.js.erb'}
      end
    end
  end

  def modify
    #deactivate, add, ban, leave
    other_user=User.find(params[:user_id]) if !params[:user_id].nil?
    modify={
      role: @role,
      user: current_user,
      other_user: other_user,
      action: params[:a]
    }
    @group.modify(modify)
    redirect_to group_path(@group)
  end

  private
    def set_group
      @group = Group.find_by(slug: params[:slug])
      role=Role.find_by(group_id: @group.id, user_id: current_user.id)
      if role.nil?
        @role=""
      else
        @role=role.role_type
      end
    end

    def group_params
      params.require(:group).permit(:groupname, :modify, :user_id)
    end
end
