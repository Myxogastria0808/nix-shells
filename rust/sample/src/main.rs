use axum::{routing::get, Router};
#[tokio::main(flavor = "current_thread")]
async fn main() {
    //Router
    let app = Router::new().route("/", get(top_handler));

    //Server
    let listener = tokio::net::TcpListener::bind("127.0.0.1:3000")
        .await
        .unwrap();
    println!("listening on http://{}", listener.local_addr().unwrap());
    axum::serve(listener, app).await.unwrap();
}

//Handler
async fn top_handler() -> String {
    "Hello, World!".to_string()
}
