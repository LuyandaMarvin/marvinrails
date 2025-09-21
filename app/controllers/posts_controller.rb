class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :ensure_admin_user, only: [:new, :create, :edit, :update, :destroy]

  # GET /posts or /posts.json
  def index
    @posts = Post.all

    if params[:query].present?
      query = "%#{params[:query]}%"
      @posts = @posts.where("title ILIKE ? OR description ILIKE ?", query, query)
    end

    respond_to do |format|
      format.html
      format.turbo_stream { render partial: "posts/posts_list", locals: { posts: @posts } }
    end

    if params[:category_id].present?
      @posts = @posts.joins(:categories).where(categories: { id: params[:category_id] }).distinct
    else
      @posts = Post.all
    end

    @categories = Category.all

  end

  def ensure_admin_user
    unless current_user&.email == Rails.application.credentials.dig(:admin, :email)
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_path, notice: "Post was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.expect(post: [ :title, :description, :thumbnail_url, :video_url, :pro, category_ids: [] ])
    end
end
