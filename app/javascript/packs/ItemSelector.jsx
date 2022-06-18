import React, { useMemo, useState } from "react";
import { Form, InputGroup, Dropdown } from "react-bootstrap";

export default React.forwardRef(
  ({ items, placeholder, initialFilter, onChange, onBlur, name }, ref) => {
    if (!items) return null;

    const filters = [
      { key: "資産・負債", typeIds: [1, 3] },
      { key: "費用", typeIds: [2] },
      { key: "利益", typeIds: [5] },
      { key: "資本", typeIds: [4] },
      { key: "フィルタなし", typeIds: [1, 2, 3, 4, 5] },
    ];
    const [filter, setFilter] = useState(
      filters.find((f) => f["key"] === initialFilter) || filters[0]
    );
    const filteredItems = useMemo(
      () =>
        [{ id: null, name: placeholder }].concat(
          items.filter((item) => filter.typeIds.includes(item.type_id))
        ),
      [items, filter]
    );

    return (
      <Form.Group>
        <InputGroup>
          <Dropdown>
            <Dropdown.Toggle variant="outline-secondary">
              {filter["key"]}
            </Dropdown.Toggle>
            <Dropdown.Menu>
              {filters.map((filter) => (
                <Dropdown.Item
                  key={filter.key}
                  onClick={() => setFilter(filter)}
                >
                  {filter.key}
                </Dropdown.Item>
              ))}
            </Dropdown.Menu>
          </Dropdown>
          <Form.Select
            ref={ref}
            name={name}
            onChange={onChange}
            onBlur={onBlur}
          >
            {filteredItems.map((item) => (
              <option key={item.id} value={item.id}>
                {item.name}
              </option>
            ))}
          </Form.Select>
        </InputGroup>
      </Form.Group>
    );
  }
);
