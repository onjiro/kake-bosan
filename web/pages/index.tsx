import Head from "next/head";
import { Row, Col, Container, Button } from "react-bootstrap";
import styled from "styled-components";
import LoginButton from "../components/login_button";
import { useUser } from "@auth0/nextjs-auth0";
import Redirect from "../components/redirect";

const StyledContainer = styled(Container)`
  margin-top: 3rem;
`;
const StyledCol = styled(Col)`
  background: rgb(248, 249, 250);
  border-radius: 8px;
  padding-top: 1.5rem;
  padding-bottom: 1.5rem;
`;
const HeadingText = styled.h1``;
const SubHeadingText = styled.h3`
  font-size: 0.875em;
`;
const DescriptionText = styled.p`
  font-size: 0.875em;
`;

export default function Home(): JSX.Element {
  const { user, error, isLoading } = useUser();
  if (user) {
    return <Redirect page="dashboard">Signing in...</Redirect>;
  }

  return (
    <>
      <Head>
        <title>家計簿さん</title>
      </Head>
      <StyledContainer>
        <Row>
          <StyledCol lg={8}>
            <HeadingText>家計簿さん</HeadingText>
            <p>複式簿記で家計簿を！</p>
            <SubHeadingText>複式簿記なら...</SubHeadingText>
            <DescriptionText>
              現金や電子マネー、クレジットカードなどの支払いと残高をまとめて管理できます。
            </DescriptionText>
            <p>
              <LoginButton>ログイン</LoginButton>
            </p>
          </StyledCol>
        </Row>
      </StyledContainer>
      <Container>
        <Row>
          <Col>
            <p>
              &copy;{" "}
              <a
                href="https://twitter.com/onjiro_mohyahya"
                target="_blank"
                rel="noreferrer"
              >
                @onjiro_mohyahya
              </a>{" "}
              2013-2022
            </p>
          </Col>
        </Row>
      </Container>
    </>
  );
}
