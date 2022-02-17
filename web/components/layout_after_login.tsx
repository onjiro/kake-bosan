import { Container, Row, Navbar, Nav, NavDropdown } from "react-bootstrap";
import { useUser } from "@auth0/nextjs-auth0";

export default function EntryForm({ children }): JSX.Element {
  const { user, isLoading, error } = useUser();

  return (
    <>
      <Navbar bg="light" expand="lg">
        <Container fluid>
          <Navbar.Brand href="/">家計簿さん</Navbar.Brand>
          <Nav>
            <NavDropdown title={"ログイン中: " + user?.name}>
              <NavDropdown.Item href="/api/auth/logout">
                ログアウト
              </NavDropdown.Item>
            </NavDropdown>
          </Nav>
        </Container>
      </Navbar>
      <Container fluid>
        <Row>{children}</Row>
      </Container>
    </>
  );
}
