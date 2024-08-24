import express from "express";
import cors from "cors";

const app = express();

const PORT = 5000;
const IPADRESS = "127.0.0.1";

//CORS
const corsOptions = {
  origin: "*",
  methods: ["GET"],
  allowedHeaders: ["*"],
  exposedHeaders: ["*"],
  credentials: true,
  optionSuccessStatus: 204,
};

app.use(cors(corsOptions));

const listener = app
  .listen(PORT, IPADRESS, () => {
    console.log(`server stating port: http://${IPADRESS}:${PORT}/`);
  })
  .on("error", (error) => {
    throw new Error(error.message);
  });

//エンドポイントの指定
app.get("/", (req, res) => {
  res.send("Hello World");
});
