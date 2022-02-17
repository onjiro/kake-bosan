import { AppProps } from "next/app";
import Head from "next/head";
import "bootstrap/dist/css/bootstrap.min.css";
import { UserProvider } from "@auth0/nextjs-auth0";

// @see https://zenn.dev/anozon/articles/ts-nextjs-pages
const App = ({ Component, pageProps }: AppProps) => (
  <UserProvider>
    <Head>
      <meta
        name="viewport"
        content="width=device-width, initial-scale=1, shrink-to-fit=no"
      />
      {/* <link rel="shortcut icon" href="/favicon.png" key="shortcutIcon" /> */}
      {/* <link rel="manifest" href="/manifest.json" /> */}
    </Head>
    <Component {...pageProps} />
  </UserProvider>
);

export default App;
