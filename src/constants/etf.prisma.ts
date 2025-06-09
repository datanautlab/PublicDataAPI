export const etfSelect = {
  name: true,
  isin: true,
  benchmark: true,
  asset_class: true,
  theme: true,
  inception_date: true,
  investment_strategy: true,
  risk_level: true,
  listing_exchange: true,
  dividend_policy: true,
  replication_method: true,
  replication_model: true,
  issuer: { select: { name: true } },
} as const;

export const etfDailyInfoSelect = {
  info_date: true,
  aum: true,
  share_outstanding: true,
  nav: true,
  expense_ratio: true,
  tracking_error: true,
  creation_unit_size: true,
  redemption_unit_size: true,
  estimated_cash: true,
  derived_cash: true,
} as const;

export const etfDailyCompositionSelect = {
  info_date: true,
  num_shares: true,
  security: {
    select: {
      name: true,
      type: true,
      sector: true,
      isin: true,
    },
  },
} as const;
