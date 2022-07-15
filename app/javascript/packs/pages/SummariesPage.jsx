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
} from "react-bootstrap";
import { useForm } from "react-hook-form";
import { BsCalendarRange, BsClock, BsDash } from "react-icons/bs";
import useSummaries from "../hooks/useSummaries";

export default () => {
  const [searchRange, setSearchRange] = useState({
    from: format(subDays(new Date(), 30), "yyyy-MM-dd"),
    to: format(new Date(), "yyyy-MM-dd"),
  });
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
        <ListGroup variant="flush">
          {summaries
            ?.filter((i) => i.amount !== 0)
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
