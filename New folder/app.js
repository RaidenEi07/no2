const express = require('express');
const app = express();
const port = 3000;

// Dữ liệu chứng khoán mẫu
const stockData = [
  {
    symbol: 'A32',
    exchange: 'UPCOM',
    companyName: 'CTCP 32',
    isFavorite: false,
  },

  {
    symbol: 'A33',
    exchange: 'UPCOM',
    companyName: 'CTCP 33',
    isFavorite: false,
  },

  {
    symbol: 'A34',
    exchange: 'UPCOM',
    companyName: 'CTCP 34',
    isFavorite: false,
  },

  {
    symbol: 'A35',
    exchange: 'UPCOM',
    companyName: 'CTCP 35',
    isFavorite: false,
  },

  {
    symbol: 'A36',
    exchange: 'UPCOM',
    companyName: 'CTCP 36',
    isFavorite: false,
  },
  // Có thể thêm nhiều dữ liệu khác
];

// Endpoint API để lấy dữ liệu
app.get('/stocks', (req, res) => {
  res.json(stockData);
});

// Endpoint API để cập nhật trạng thái yêu thích
app.post('/stocks/:symbol/favorite', (req, res) => {
  const symbol = req.params.symbol;
  const stock = stockData.find(stock => stock.symbol === symbol);

  if (stock) {
    stock.isFavorite = !stock.isFavorite;
    res.json({ message: 'Cập nhật trạng thái yêu thích thành công', stock });
  } else {
    res.status(404).json({ message: 'Không tìm thấy mã chứng khoán' });
  }
});

app.listen(port, () => {
  console.log(`Server chạy trên cổng ${port}`);
});
