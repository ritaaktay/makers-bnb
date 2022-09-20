class RequestRepository

  def all
    sql = "SELECT * FROM requests"
    results = DB.exec(sql)
  end

end