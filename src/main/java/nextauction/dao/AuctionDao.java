public List<Auction> searchAuctions(String query) {
    List<Auction> auctions = new ArrayList<>();
    String sql = "SELECT * FROM auctions WHERE item_name LIKE ? OR category LIKE ? OR description LIKE ?";

    try (Connection conn = DBUtil.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {

        String pattern = "%" + query + "%";
        ps.setString(1, pattern);
        ps.setString(2, pattern);
        ps.setString(3, pattern);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Auction a = new Auction();
            a.setId(rs.getInt("id"));
            a.setItemName(rs.getString("item_name"));
            a.setCategory(rs.getString("category"));
            a.setDescription(rs.getString("description"));
            a.setStartingPrice(rs.getDouble("starting_price"));
            a.setCurrentBid(rs.getDouble("current_bid"));
            auctions.add(a);
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return auctions;
}
