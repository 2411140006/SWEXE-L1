class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # 存在しないIDにアクセスされた場合のエラー処理
  rescue_from ActiveRecord::RecordNotFound do
    redirect_to books_path, alert: "指定された本が見つかりませんでした。"
  end

  # GET /books
  def index
    @books = Book.all.order(created_at: :desc)
  end

  # GET /books/:id
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # POST /books
  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: "「#{@book.title}」を登録しました。"
    else
      flash.now[:alert] = "入力内容に誤りがあります。ご確認ください。"
      render :new, status: :unprocessable_entity
    end
  end

  # GET /books/:id/edit
  def edit
  end

  # PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      redirect_to @book, notice: "「#{@book.title}」の情報を更新しました。"
    else
      flash.now[:alert] = "入力内容に誤りがあります。ご確認ください。"
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /books/:id
  def destroy
    title = @book.title
    @book.destroy
    redirect_to books_path, notice: "「#{title}」を削除しました。", status: :see_other
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :published_on, :description)
  end
end