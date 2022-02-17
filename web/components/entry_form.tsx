import {
  Form,
  FormControl,
  Button,
  Row,
  Col,
  InputGroup,
} from "react-bootstrap";

export default function EntryForm(): JSX.Element {
  return (
    <>
      <Form>
        <fieldset>
          <Row>
            <Col sm={4}>
              <InputGroup className="mb-2">
                <InputGroup.Text>@{/* TODO アイコン */}</InputGroup.Text>
                <FormControl type="date"></FormControl>
              </InputGroup>
            </Col>
          </Row>
          <Row className="mb-1">
            <Col sm={4}>{/* TODO 科目選択 */}</Col>
            <Col sm={2}>
              <InputGroup>
                <InputGroup.Text>&yen;</InputGroup.Text>
                <FormControl type="number" placeholder="借方金額"></FormControl>
              </InputGroup>
            </Col>
            <Col sm={3}>{/* TODO 科目選択 */}</Col>
            <Col sm={2}>
              <InputGroup>
                <InputGroup.Text>&yen;</InputGroup.Text>
                <FormControl type="number" placeholder="貸方金額"></FormControl>
              </InputGroup>
            </Col>
            <Col sm={1}>
              <Button variant="danger">
                x
                {/* <%= bootstrap_icon "backspace", width: 24, height: 24 %> */}
              </Button>
            </Col>
          </Row>

          <Row className="mt-2">
            <Col sm={9} className="d-grid">
              <Button variant="light">+ 行を追加</Button>
            </Col>
            <Col sm={2} className="d-grid">
              <Button variant="primary" type="submit">
                登録
              </Button>
            </Col>
          </Row>
        </fieldset>
      </Form>
    </>
  );
}
