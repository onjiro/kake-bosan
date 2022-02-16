import Head from "next/head";

export default function Home(): JSX.Element {
  return (
    <>
      <Head>
        <title>家計簿さん</title>
      </Head>
      <section className="container mt-5">
        <div className="row">
          <div className="col-8 bg-light pt-4 pb-4" style={{ borderRadius: 8 }}>
            <h1>家計簿さん</h1>
            <p>複式簿記で家計簿を！</p>
            <h3 className="small">複式簿記なら...</h3>
            <small className="small">
              現金や電子マネー、クレジットカードなどの支払いと残高をまとめて管理できます。
            </small>
            <p>
              <span className="btn btn-primary">開発者としてログイン</span>
              <span className="btn btn-primary">GitHubでログイン</span>
            </p>
          </div>
        </div>
      </section>
      <footer className="container">
        <p className="row">
          <span className="pull-right">
            &copy;{" "}
            <a
              href="https://twitter.com/onjiro_mohyahya"
              target="_blank"
              rel="noreferrer"
            >
              @onjiro_mohyahya
            </a>{" "}
            2013-2021
          </span>
        </p>
      </footer>
    </>
  );
}
