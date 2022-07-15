import format from "date-fns/format";
import subDays from "date-fns/subDays";
import React, { useState } from "react";
import {
  ListGroup,
  ListGroupItem,
  Row,
  Col,
  Button,
  Form,
  InputGroup,
  Nav,
} from "react-bootstrap";
import { useForm } from "react-hook-form";
import { BsCalendarRange, BsDash } from "react-icons/bs";
import useSummaries from "../hooks/useSummaries";

const ACCOUNTING_TYPES = [
  { id: 1, key: "asset", label: "資産" },
  { id: 2, key: "expense", label: "費用" },
  { id: 3, key: "liability", label: "負債" },
  { id: 4, key: "capital", label: "資本" },
  { id: 5, key: "income", label: "収益" },
];

export default () => {
  const [searchRange, setSearchRange] = useState({
    from: format(subDays(new Date(), 30), "yyyy-MM-dd"),
    to: format(new Date(), "yyyy-MM-dd"),
  });
  const [selectedType, setSelectedType] = useState(
    ACCOUNTING_TYPES.find((type) => type.key === "expense")
  );

  const { summaries, error } = useSummaries(searchRange);
  const { register, handleSubmit, watch, setValue, formState } = useForm();
  const search = handleSubmit((formData, e) => {
    e.preventDefault();
    setSearchRange({
      from: format(formData.from, "yyyy-MM-dd"),
      to: format(formData.to, "yyyy-MM-dd"),
    });
  });

  return (
    <>
      <Row>
        <h3>集計</h3>
      </Row>

      <Form className="mb-5" onSubmit={search}>
        <Row className="mb-2">
          <Col>
            <Form.Group>
              <InputGroup>
                <InputGroup.Text>
                  <BsCalendarRange />
                </InputGroup.Text>
                <Form.Control
                  type="date"
                  {...register("from", { required: true, valueAsDate: true })}
                  defaultValue={searchRange.from}
                  isInvalid={formState.errors.from}
                />
                <InputGroup.Text>
                  <BsDash />
                </InputGroup.Text>
                <Form.Control
                  type="date"
                  {...register("to", { required: true, valueAsDate: true })}
                  defaultValue={searchRange.to}
                  isInvalid={formState.errors.to}
                />
              </InputGroup>
            </Form.Group>
          </Col>
        </Row>
        <div className="d-grid gap-2">
          <Button variant="primary" type="submit">
            集計
          </Button>
        </div>
      </Form>

      <Row>
        <h4>
          {searchRange.from} ~ {searchRange.to}
        </h4>
      </Row>
      <Row>
        <Nav fill variant="tabs" defaultActiveKey={selectedType.key}>
          {ACCOUNTING_TYPES.map((type) => (
            <Nav.Item key={type.key}>
              <Nav.Link
                eventKey={type.key}
                onClick={() => setSelectedType(type)}
              >
                {type.label}
              </Nav.Link>
            </Nav.Item>
          ))}
        </Nav>
        <ListGroup variant="flush">
          {summaries
            ?.filter((i) => i.item.type_id === selectedType.id)
            .filter((i) => i.amount !== 0)
            .map((i) => (
              <ListGroupItem
                key={i.item.id}
                className="list-group-item list-group-item-action"
              >
                <div className="clearfix">
                  <span>{i.item.name}</span>
                  <span className="float-end">
                    <span>&yen;{i.amount}</span>
                  </span>
                </div>
              </ListGroupItem>
            ))}
        </ListGroup>
      </Row>
    </>
  );
};
