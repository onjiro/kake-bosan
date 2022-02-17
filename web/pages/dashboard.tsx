import { Row, Col, Alert } from "react-bootstrap";
import LayoutAfterLogin from "../components/layout_after_login";
import EntryForm from "../components/entry_form";
import Histories from "../components/histories";
import withAuth from "../components/with_auth";

function Dashboard(): JSX.Element {
  return (
    <LayoutAfterLogin>
      <div className="pt-4 mb-5">
        <h3>▼登録</h3>
        <Row>
          <Col sm={12}>
            <EntryForm></EntryForm>
          </Col>
        </Row>
      </div>

      <div className="mb-5">
        <h3>▼直近７日間の履歴</h3>
        <Row>
          <Col sm={12}>
            <Histories></Histories>
            <Alert variant="info">直近のあれはありません</Alert>
            <Alert variant="light">ロード中...</Alert>
          </Col>
        </Row>
      </div>
    </LayoutAfterLogin>
  );
}
export default withAuth(Dashboard);
